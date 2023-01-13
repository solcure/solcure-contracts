import * as dotenv from "dotenv";
import { HardhatUserConfig, task } from "hardhat/config";
import hardhatNetworks from "./hardhat.networks";
import solidityConfiguration from "./hardhat.solidity.config";

import "@nomicfoundation/hardhat-toolbox";  // https://www.npmjs.com/package/@nomicfoundation/hardhat-toolbox
import "@nomiclabs/hardhat-ethers";
import "solidity-coverage"
import "@typechain/hardhat"
import '@openzeppelin/hardhat-upgrades';
import 'solidity-docgen';

dotenv.config();

const config: HardhatUserConfig = {
  solidity: solidityConfiguration,
  networks: hardhatNetworks,
  paths: {
    artifacts: "./artifacts",
    cache: "./cache",
    sources: "./contracts",
    tests: "./tests",
  },
  typechain: {
    outDir: "types",
    target: "ethers-v5",
  },
  gasReporter: {
    enabled: true
  },
  mocha: {
    timeout: 4000000
  },
  docgen: {
    pages: 'files'
  }
};

export default config;