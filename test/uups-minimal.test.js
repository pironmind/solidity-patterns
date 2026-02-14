const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("UUPSMinimal", function () {
  it("upgrades CounterV1 -> CounterV2 and preserves storage", async function () {
    const [deployer] = await ethers.getSigners();

    const CounterV1 = await ethers.getContractFactory("CounterV1");
    const v1 = await CounterV1.deploy();
    await v1.deployed();

    const initData = v1.interface.encodeFunctionData("initialize", [deployer.address]);

    const Proxy = await ethers.getContractFactory("ERC1967Proxy");
    const proxy = await Proxy.deploy(v1.address, initData);
    await proxy.deployed();

    const counterAsV1 = await ethers.getContractAt("CounterV1", proxy.address);

    await (await counterAsV1.inc()).wait();
    expect(await counterAsV1.value()).to.equal(ethers.BigNumber.from(1));
    expect(await counterAsV1.owner()).to.equal(deployer.address);

    const CounterV2 = await ethers.getContractFactory("CounterV2");
    const v2 = await CounterV2.deploy();
    await v2.deployed();

    await (await counterAsV1.upgradeTo(v2.address)).wait();

    const counterAsV2 = await ethers.getContractAt("CounterV2", proxy.address);
    expect(await counterAsV2.value()).to.equal(ethers.BigNumber.from(1));

    await (await counterAsV2.dec()).wait();
    expect(await counterAsV2.value()).to.equal(ethers.BigNumber.from(0));
  });

  it("prevents non-owner upgrades", async function () {
    const [owner, attacker] = await ethers.getSigners();

    const CounterV1 = await ethers.getContractFactory("CounterV1");
    const v1 = await CounterV1.deploy();
    await v1.deployed();

    const initData = v1.interface.encodeFunctionData("initialize", [owner.address]);

    const Proxy = await ethers.getContractFactory("ERC1967Proxy");
    const proxy = await Proxy.deploy(v1.address, initData);
    await proxy.deployed();

    const CounterV2 = await ethers.getContractFactory("CounterV2");
    const v2 = await CounterV2.deploy();
    await v2.deployed();

    const counterAsV1FromAttacker = await ethers.getContractAt(
      "CounterV1",
      proxy.address,
      attacker
    );

    await expect(counterAsV1FromAttacker.upgradeTo(v2.address))
      .to.be.revertedWithCustomError(v1, "UnauthorizedUpgrade")
      .withArgs(attacker.address);
  });
});
