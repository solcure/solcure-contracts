import { NetworksUserConfig } from "hardhat/src/types/config";
import * as dotenv from "dotenv";

dotenv.config();

const networks = {
  hardhat: {
    mining: {
      auto: true,
      interval: 15000
    },
    saveDeployments: true,
    deploy: [ 'deploy' ]
  }
};

export default networks;