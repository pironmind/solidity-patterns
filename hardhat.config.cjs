require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-chai-matchers");

/** @type {import('hardhat/config').HardhatUserConfig} */
module.exports = {
  // These examples are written for Solidity 0.4.x.
  // Hardhat will download the matching solc version automatically.
  solidity: {
    compilers: [
      { version: "0.8.28", settings: { evmVersion: "prague" } },
    ],
  },
  paths: {
    // Hardhat treats everything under `paths.sources` as a local source.
    // Pointing it at the repo root makes it accidentally pick up `node_modules/**.sol`
    // (e.g. Hardhat's own `console.sol`), which Hardhat rejects.
    //
    // Keep sources in a dedicated folder and reference the pattern contracts from there.
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};
