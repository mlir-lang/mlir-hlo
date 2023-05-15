// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<4x6xui32>
    %1 = call @expected() : () -> tensor<3x5xui32>
    %2 = stablehlo.constant dense<4294967295> : tensor<ui32>
    %3 = stablehlo.broadcast_in_dim %2, dims = [] : (tensor<ui32>) -> tensor<ui32>
    %4 = "stablehlo.reduce_window"(%0, %3) ({
    ^bb0(%arg0: tensor<ui32>, %arg1: tensor<ui32>):
      %6 = stablehlo.minimum %arg0, %arg1 : tensor<ui32>
      stablehlo.return %6 : tensor<ui32>
    }) {window_dimensions = dense<2> : tensor<2xi64>} : (tensor<4x6xui32>, tensor<ui32>) -> tensor<3x5xui32>
    %5 = stablehlo.custom_call @check.eq(%4, %1) : (tensor<3x5xui32>, tensor<3x5xui32>) -> tensor<i1>
    return %5 : tensor<i1>
  }
  func.func private @inputs() -> tensor<4x6xui32> {
    %0 = stablehlo.constant dense<[[3, 1, 0, 6, 1, 1], [1, 3, 1, 1, 2, 5], [0, 3, 0, 0, 6, 4], [1, 2, 1, 1, 4, 4]]> : tensor<4x6xui32>
    return %0 : tensor<4x6xui32>
  }
  func.func private @expected() -> tensor<3x5xui32> {
    %0 = stablehlo.constant dense<[[1, 0, 0, 1, 1], [0, 0, 0, 0, 2], [0, 0, 0, 0, 4]]> : tensor<3x5xui32>
    return %0 : tensor<3x5xui32>
  }
}

