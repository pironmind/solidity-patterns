const { expect } = require("chai");
const { ethers } = require("hardhat");

function splitSig(sig) {
  const r = sig.slice(0, 66);
  const s = "0x" + sig.slice(66, 130);
  const v = parseInt(sig.slice(130, 132), 16);
  return { v, r, s };
}

describe("EIP712PermitToken", function () {
  it("permits via EIP-712 signature", async function () {
    const [owner, spender] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("EIP712PermitToken");
    const token = await Token.deploy("PermitToken", "PERMIT");
    await token.deployed();

    const value = ethers.utils.parseEther("1");
    const deadline = (await ethers.provider.getBlock("latest")).timestamp + 3600;

    const nonce = await token.nonces(owner.address);
    const chainId = (await ethers.provider.getNetwork()).chainId;

    const domain = {
      name: "PermitToken",
      version: "1",
      chainId,
      verifyingContract: token.address,
    };

    const types = {
      Permit: [
        { name: "owner", type: "address" },
        { name: "spender", type: "address" },
        { name: "value", type: "uint256" },
        { name: "nonce", type: "uint256" },
        { name: "deadline", type: "uint256" },
      ],
    };

    const message = {
      owner: owner.address,
      spender: spender.address,
      value: value.toString(),
      nonce: nonce.toString(),
      deadline: deadline.toString(),
    };

    const sig = await owner._signTypedData(domain, types, message);
    const { v, r, s } = splitSig(sig);

    await (await token.permit(owner.address, spender.address, value, deadline, v, r, s)).wait();

    expect(await token.allowance(owner.address, spender.address)).to.equal(value);
  });

  it("rejects expired deadline", async function () {
    const [owner, spender] = await ethers.getSigners();

    const Token = await ethers.getContractFactory("EIP712PermitToken");
    const token = await Token.deploy("PermitToken", "PERMIT");
    await token.deployed();

    const value = 123;
    const deadline = 1; // already expired

    const nonce = await token.nonces(owner.address);
    const chainId = (await ethers.provider.getNetwork()).chainId;

    const domain = {
      name: "PermitToken",
      version: "1",
      chainId,
      verifyingContract: token.address,
    };

    const types = {
      Permit: [
        { name: "owner", type: "address" },
        { name: "spender", type: "address" },
        { name: "value", type: "uint256" },
        { name: "nonce", type: "uint256" },
        { name: "deadline", type: "uint256" },
      ],
    };

    const message = {
      owner: owner.address,
      spender: spender.address,
      value: value.toString(),
      nonce: nonce.toString(),
      deadline: deadline.toString(),
    };

    const sig = await owner._signTypedData(domain, types, message);
    const { v, r, s } = splitSig(sig);

    await expect(token.permit(owner.address, spender.address, value, deadline, v, r, s)).to.be.reverted;
  });
});
