use starknet::ContractAddress;
/// Interface for the  swapramp contract
#[starknet::interface]
pub trait ISwapOffRamp<TContractState> {
    // EXTERNAL
    /// swap function for handling aceeptance of token for offramp
    fn off_ramp_usdt(ref self: TContractState, amount: u256, unique_ref: ByteArray);
    fn off_ramp_usdc(ref self: TContractState, amount: u256, unique_ref: ByteArray);
}
