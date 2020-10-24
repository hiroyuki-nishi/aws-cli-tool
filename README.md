# aws-cli-tool

### Requirements

- cargo
- cargo-make
  https://github.com/sagiegurari/cargo-make
- jq

### Installation

```
curl https://sh.rustup.rs -sSf | sh
cargo install --force cargo-make

```

### 利用方法

- SQS からキューを再帰的に取得するタスク

```
cargo make --makefile task.toml sqs-receive <ループ回数> <プロファイル> <QueueのURL>
```

- 1.Kinesis の SequenceNumber から Iterator を取得するタスク

```
cargo make --makefile task.toml kinesis-get-shard-iterator <stream-name> <starting-sequence-number> <profile>
```

- 2.Kinesis の Iterator から Records を取得するタスク

```

cargo make --makefile task.toml kinesis-get-records <iterator> <profile>

```
