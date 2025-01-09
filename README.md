# Project Description

SWAPRAMP is onramp and offramp solution that allow user swap their fiat into USDT and USDC on stack and also swap their stable asset like USDC AND USDT on stack to fiat currency.

## Development Setup

You will need to have Scarb and Starknet Foundry installed on your system. Refer to the documentations below:

- [Starknet Foundry](https://foundry-rs.github.io/starknet-foundry/index.html)
- [Scarb](https://docs.swmansion.com/scarb/download.html)

To use this repository, first clone it:

```
git clone https://github.com/swapramp/swapramp_contracts.git
cd swapramp_contracts
```

### Building contracts

To build the contracts, run the command:

- setup scarb via asdf

```
asdf local scarb 2.8.3
```

- setup starknet-foundry via asdf

```
asdf local starknet-foundry 0.31.0
```

- Build

```
scarb build
```

### Running Tests

To run the tests contained within the `tests` folder, run the command:

```
snforge test
```
