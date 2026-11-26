## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

## Tokenomics - CertiChain Test Token (CCT)

Este proyecto implementa un token ERC-20 de prueba para el laboratorio de Blockchain.

### Características

- **Nombre:** CertiChain Test Token
- **Símbolo:** CCT
- **Decimales:** 6
- **Suministro inicial:** 1.000.000 CCT
- **Destinatario inicial:** propietario del contrato.
- **Emisión adicional:** no permitida. El suministro es fijo.

### Justificación de las decisiones

Se eligieron 6 decimales porque permiten representar cantidades fraccionarias y mantienen una escala similar a la utilizada por stablecoins como USDC.

El suministro inicial de 1.000.000 CCT es suficiente para realizar pruebas de transferencias y aprobaciones.

Se eliminó la función mint para impedir la emisión de nuevos tokens después del despliegue. De esta manera, el propietario no puede aumentar unilateralmente el suministro ni diluir los saldos existentes.

### Relación con CertiChain Pay

CCT es exclusivamente un token de prueba creado para cumplir los requisitos del laboratorio. En el diseño real de CertiChain Pay se contempla utilizar USDC para los pagos de las instituciones, sin crear una moneda propia.
