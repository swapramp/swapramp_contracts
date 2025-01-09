use starknet::ContractAddress;

#[starknet::contract]
pub mod SupportFund {
    // ***************************************************************************************
    //                            IMPORT
    // ***************************************************************************************
    use core::array::ArrayTrait;
    use core::traits::TryInto;
    use core::starknet::{
        ContractAddress, get_caller_address, syscalls::deploy_syscall, ClassHash,
        get_block_timestamp, contract_address_const, get_contract_address,
        storage::{Map, StorageMapReadAccess, StorageMapWriteAccess, StoragePathEntry}
    };
    use swapramp_contract::interfaces::ISwapOffRamp::ISwapOffRamp;
    use swapramp_contract::base::errors::Errors::{
        ZERO_AMOUNT, INSUFFICIENT_ALLOWANCE, INVALID_TOKEN
    };
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};
    // CONSTANTS

    // ***************************************************************************************
    //                            STORAGE
    // ***************************************************************************************
    #[storage]
    struct Storage {
        id: u256,
        owner: ContractAddress,
        name: ByteArray,
        reason: ByteArray,
        goal_amount: u256,
        state: u256,
        contact_handler: ByteArray,
        fund_type: u256,
        support_fund_voters: Map::<ContractAddress, u64>,
        support_fund_votes: u256,
        strk_token: ContractAddress,
    }
}
