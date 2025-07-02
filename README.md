# Preliminary support of Swift on Clever Cloud

As Clever Cloud works on a native Swift support, you can start to experiment it with our `Linux` runtime and `swiftc` compiler. This example shows how to build a simple Swift Server on `8080` port, using [Clever Tools](https://github.com/CleverCloud/clever-tools/).

## Clone this repository and deploy (as easy as 1-2-3)

```bash
git clone https://github.com/CleverCloud/swift-hello-world-example
cd swift-hello-world-example

clever create -t linux
clever deploy
```

You don't need to configure anything, as Build and Run scripts are configured through the `mise.toml` file.
