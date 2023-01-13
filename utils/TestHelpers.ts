import { BaseContract, BytesLike, Contract, ContractFactory, Signer } from "ethers";
import { artifacts, ethers, network, upgrades } from "hardhat";

export async function deployContract(contractName: string, ...args: any): Promise<Contract> {
    const creation = await ethers.getContractFactory(contractName);
    const deployment = await creation.deploy(...args ?? []);
    console.log("Deployed ", contractName, " to: ", deployment.address);
    return deployment;
}

export async function deployFromFactoryAs<C extends Contract>(factory: ContractFactory, ...args: any): Promise<C> {
    const deployment = await factory.deploy(...args ?? []);
    console.log("Deployed ", factory.constructor.name, " to: ", deployment.address);
    return deployment as C;
}

export async function deployUpgradeableContract(contractName: string, ...args: any): Promise<Contract> {
    const creation = await ethers.getContractFactory(contractName);
    const instance = await upgrades.deployProxy(creation, [...args] ?? [], { unsafeAllow: ["state-variable-assignment"] });
    const deployment = await instance.deployed();
    console.log("Deployed ", contractName, " to: ", instance.address);
    return deployment;
}

export async function deployUpgradeableContractAs<T extends BaseContract>(contractName: string, ...args: any): Promise<T> {
    const creation = await ethers.getContractFactory(contractName);
    let instance = await upgrades.deployProxy(creation, [...args] ?? []);
    instance = await instance.deployed();
    console.log("Deployed ", contractName, " to: ", instance.address);
    return instance as T;
}

export async function deployUpgradeableFromFactoryAs<C extends Contract>(factory: ContractFactory, ...args: any): Promise<C> {
    let instance = await upgrades.deployProxy(factory, [...args] ?? []);
    instance = await instance.deployed();
    console.log("Deployed ", factory.constructor.name, " to: ", instance.address);
    return instance as C;
}

export function createNodeHash(nodeA: number, nodeB: number): number {
    return nodeA | (nodeB << 8);
}

export function readNodeHash(nodeHash: number): [number, number] {
    return [nodeHash & 0xFF, nodeHash >> 8];
}

export const blockTimestamp = async (): Promise<number> => {
    return (await ethers.provider.getBlock(await ethers.provider.getBlockNumber())).timestamp
}

export const mineToTimestamp = async (timestamp: number) => {
    const currentTimestamp = (await ethers.provider.getBlock(await ethers.provider.getBlockNumber())).timestamp
    if (timestamp < currentTimestamp) {
        throw new Error("Cannot mine a timestamp in the past");
    }

    await network.provider.send("evm_increaseTime", [(timestamp - currentTimestamp)])
    await network.provider.send("evm_mine");
}

export const mineForwardSeconds = async (seconds: number) => {
    await mineToTimestamp(await blockTimestamp() + seconds);
}

export const mineForwardHours = async (hours: number) => {
    await mineToTimestamp(await blockTimestamp() + (hours * 3600));
}

export const mineForwardDays = async (days: number) => {
    await mineToTimestamp(await blockTimestamp() + (days * 86400));
}