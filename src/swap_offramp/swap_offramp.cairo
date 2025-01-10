use starknet::ContractAddress;

#[starknet::contract]
pub mod SwapOffRamp {
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
    use swapramp_contract::base::types::OffRampDetails;
    use openzeppelin::token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};

    // ***************************************************************************************
    //                            STORAGE
    // ***************************************************************************************
    #[storage]
    struct Storage {
        id: u256,
        owner: ContractAddress,
        total_offramp_amount_usdc: u256,
        total_offramp_amount_usdt: u256,
        off_ramps: Map::<ContractAddress, (u256, OffRampDetails)>,
        strk_usdt_token_address: ContractAddress,
        strk_usdc_token_address: ContractAddress,
    }

    // ***************************************************************************************
    //                            EVENTS
    // ***************************************************************************************
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ReceivedFund: ReceivedFund,
        // #[flat]
        // OwnableEvent: OwnableComponent::Event,
        // #[flat]
        // UpgradeableEvent: UpgradeableComponent::Event,
    }

    #[derive(Drop, starknet::Event)]
    struct ReceivedFund {
        #[key]
        caller: ContractAddress,
        token: ContractAddress,
        token_type: ByteArray,
        amount: u256,
        unique_ref: ByteArray,
    }

    // ***************************************************************************************
    //                            CONSTRUCTOR
    // ***************************************************************************************
    #[constructor]
    fn constructor(ref self: ContractState, strk_usdt_token_address: ContractAddress, strk_usdc_token_address: ContractAddress) {
        self.owner.write(get_caller_address());
        self.strk_usdt_token_address.write(strk_usdt_token_address);
        self.strk_usdc_token_address.write(strk_usdc_token_address);
    }

    // ***************************************************************************************
    //                            EXTERNALS
    // ***************************************************************************************

    #[abi(embed_v0)]
    impl ImplSwapOffRamp of ISwapOffRamp<ContractState> {
        fn off_ramp(ref self: ContractState, amount: u256, unique_ref: ByteArray, toke_type: u8,) {
            let caller = get_caller_address();
            // check if user has given the approval to transfer the amount
            assert(
                self.token_dispatcher().allowance(caller, get_contract_address()) >= amount,
                INSUFFICIENT_ALLOWANCE
            );
         
            // transfer the amount
            self.token_dispatcher().transfer_from(caller, get_contract_address(), amount);
            // give approval for contract owner to spend the funds
            self.token_dispatcher().approve(self.owner.read(), amount);
            // EMIT EVENTS

        }
    }

    // *************************************************************************
    //                            INTERNALS
    // *************************************************************************
    #[generate_trait]
    impl InternalImpl of InternalTrait {
        fn token_dispatcher(self: @ContractState) -> IERC20Dispatcher {
            IERC20Dispatcher { contract_address: self.strk_usdt_token_address.read() }
        }
    }
}
