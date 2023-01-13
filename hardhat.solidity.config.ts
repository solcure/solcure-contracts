import { MultiSolcUserConfig } from "hardhat/src/types/config";

const solidityConfiguration: MultiSolcUserConfig = {
  compilers: [
    {
      version: "0.8.17",
      settings: {
        optimizer: {
          enabled: true,
          runs: 1500,
        },
      },
    },
  ],
  overrides: undefined
}

export default solidityConfiguration;
