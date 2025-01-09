use starknet::ContractAddress;
/// Interface for the  swapramp contract
#[starknet::interface]
pub trait ISwapOffRamp<TContractState> {
    // EXTERNAL
    /// swap function for handling aceeptance of token for offramp
    fn off_ramp(
        ref self: TContractState,
        amount: u256,
        unique_ref: ByteArray,
        toke_type: ByteArray,
        network_name: ByteArray
    );
}
