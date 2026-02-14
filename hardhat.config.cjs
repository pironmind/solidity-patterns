/** @type {import('hardhat/config').HardhatUserConfig} */
module.exports = {
  // These examples are written for Solidity 0.4.x.
  // Hardhat will download the matching solc version automatically.
  solidity: {
    compilers: [
      { version: "0.4.22" },
      { version: "0.4.21" },
      { version: "0.4.20" },
      { version: "0.4.19" },
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
