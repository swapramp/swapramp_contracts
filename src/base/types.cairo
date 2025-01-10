use core::serde::Serde;
use core::option::OptionTrait;
use core::starknet::ContractAddress;

/// @title Event Details Structure
/// @notice Contains comprehensive information about an event
/// @dev Used to store and manage event-specific data
#[derive(Drop, Serde, starknet::Store, Clone)]
pub struct OffRampDetails {
    pub id: u256,
    pub unique_ref: ByteArray,
    pub owner: ByteArray,
    pub amount: u256,
    pub token_type: ByteArray,
}
