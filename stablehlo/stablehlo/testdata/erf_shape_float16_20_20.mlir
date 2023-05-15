// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf16>
    %1 = call @expected() : () -> tensor<20x20xf16>
    %2 = stablehlo.convert %0 : (tensor<20x20xf16>) -> tensor<20x20xf32>
    %3 = stablehlo.constant dense<-4.000000e+00> : tensor<20x20xf32>
    %4 = stablehlo.constant dense<4.000000e+00> : tensor<20x20xf32>
    %5 = stablehlo.clamp %3, %2, %4 : tensor<20x20xf32>
    %6 = stablehlo.multiply %5, %5 : tensor<20x20xf32>
    %7 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %8 = stablehlo.multiply %7, %6 : tensor<20x20xf32>
    %9 = stablehlo.constant dense<-2.72614237E-10> : tensor<20x20xf32>
    %10 = stablehlo.add %8, %9 : tensor<20x20xf32>
    %11 = stablehlo.multiply %10, %6 : tensor<20x20xf32>
    %12 = stablehlo.constant dense<2.77068146E-8> : tensor<20x20xf32>
    %13 = stablehlo.add %11, %12 : tensor<20x20xf32>
    %14 = stablehlo.multiply %13, %6 : tensor<20x20xf32>
    %15 = stablehlo.constant dense<-2.10102394E-6> : tensor<20x20xf32>
    %16 = stablehlo.add %14, %15 : tensor<20x20xf32>
    %17 = stablehlo.multiply %16, %6 : tensor<20x20xf32>
    %18 = stablehlo.constant dense<-5.69250624E-5> : tensor<20x20xf32>
    %19 = stablehlo.add %17, %18 : tensor<20x20xf32>
    %20 = stablehlo.multiply %19, %6 : tensor<20x20xf32>
    %21 = stablehlo.constant dense<-7.34990637E-4> : tensor<20x20xf32>
    %22 = stablehlo.add %20, %21 : tensor<20x20xf32>
    %23 = stablehlo.multiply %22, %6 : tensor<20x20xf32>
    %24 = stablehlo.constant dense<-2.954600e-03> : tensor<20x20xf32>
    %25 = stablehlo.add %23, %24 : tensor<20x20xf32>
    %26 = stablehlo.multiply %25, %6 : tensor<20x20xf32>
    %27 = stablehlo.constant dense<-0.0160960332> : tensor<20x20xf32>
    %28 = stablehlo.add %26, %27 : tensor<20x20xf32>
    %29 = stablehlo.constant dense<0.000000e+00> : tensor<20x20xf32>
    %30 = stablehlo.multiply %29, %6 : tensor<20x20xf32>
    %31 = stablehlo.constant dense<-1.45660715E-5> : tensor<20x20xf32>
    %32 = stablehlo.add %30, %31 : tensor<20x20xf32>
    %33 = stablehlo.multiply %32, %6 : tensor<20x20xf32>
    %34 = stablehlo.constant dense<-2.13374049E-4> : tensor<20x20xf32>
    %35 = stablehlo.add %33, %34 : tensor<20x20xf32>
    %36 = stablehlo.multiply %35, %6 : tensor<20x20xf32>
    %37 = stablehlo.constant dense<-0.00168282702> : tensor<20x20xf32>
    %38 = stablehlo.add %36, %37 : tensor<20x20xf32>
    %39 = stablehlo.multiply %38, %6 : tensor<20x20xf32>
    %40 = stablehlo.constant dense<-0.00737332925> : tensor<20x20xf32>
    %41 = stablehlo.add %39, %40 : tensor<20x20xf32>
    %42 = stablehlo.multiply %41, %6 : tensor<20x20xf32>
    %43 = stablehlo.constant dense<-0.0142647391> : tensor<20x20xf32>
    %44 = stablehlo.add %42, %43 : tensor<20x20xf32>
    %45 = stablehlo.multiply %5, %28 : tensor<20x20xf32>
    %46 = stablehlo.divide %45, %44 : tensor<20x20xf32>
    %47 = stablehlo.convert %46 : (tensor<20x20xf32>) -> tensor<20x20xf16>
    %48 = stablehlo.custom_call @check.eq(%47, %1) : (tensor<20x20xf16>, tensor<20x20xf16>) -> tensor<i1>
    return %48 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x58C6744009C4F840EB411D41C5C115BE8CAA503CF64467C36A410C426D4852419242D5425E425DC348339EC4D943A832CF3DEDBB2B3E7C24BA3D023CB53731C63B41C2C564362FC1BF3E1245693918BD69C2C93DAA4531441DBE34B7E6C4133ACCBD74B250447941FDC372C24AB4F44449B013BDD0B407C193C4C24095C12FB10ABE45C02044AFC07BC02645D3C2C8441540A7BEE141DEB22FA619355ABD53C0BFC0C9C5043D89C4F8C0D946C63101309F4050C6ED4334C056BE93C44EC0A9C1B93C4DB9C9C223B8D0B6A8C559C22A4464C0263F723D97BA58C403B527C6A936CEB7AC3CDAB6E9C0F63E923310BE6C4316C000BD7B41F53867C05E3D4140F8BB923E0A3EE9C3263E03BF153CA2C4C13CD8374E3FDB3E814287BA5444AEB57B433D46F34131BAEEB427C2434498BD5FBFCA3E91B33A4615B80DBA563FCEC3CDC4F0C4A5BEBD4422C081C41FC4BC429BBA98BDF83A64449FC096BE863E0B457F40D140973F50BD423EE6BE72B6A1C3E6C48BB9DBB7803CEA3D363C9443A5BEE8C3C93B4240C8C245416442C3B22146933FFC40443D2745393F5C44B33C15C136C034C2D341C5BEB9C313BF074378C0383545BBA9BF39BE3143953857BEA4C084408C4250B08037F6459E3BFC3E7741BAC65C40E9C318C8E843FBC1F54039C4932DBE43FBC06541DC3B2F446E43C5C09D40F8BD8741274574BF3CC0B740F245D6AD6F3F95BCCEBC74BD7B3A1FC06EC3F24368B62F467D36C83F2EC2AB24F84092C32F3056C2E5BFE8429AC09AC64B44C5451DC297B6A3B6284254C21ABE52BD712E543AA4BE593976464F3FF2C2D4B9A741933E4F40FCBB55C4A241A9B9A1441C3EB94754BC0236E5BD2A40C2BFE73F62C725C13FC8233D6BBC05465738CEC0ACA92744F9C48AC157403D33B345AEC56FBC013B454292A5CBC077BFDD3E0FACA64142C153448DC1D2C2FDBFA3B83841A8B5333A55349145A6B9F5BCBFC056413530B442D7C09D3EA1A5B43B3E450EC494C59EC41A46D8BC44359F41B532D9C4314375BCE7C2604463C1DCBDB4BEBAC405B8CC3E49420D2C0638983D72C2D93C6241E5C0783CCCBFFCB98D3D30423E34A8C3973717C59F380D43ADBE1CC3E3C46042"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
  func.func private @expected() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x00BCFD3B00BCFF3B003CFF3B00BCBFBB62ABFB3A003C00BC003C003C003C003C003C003C003C00BC0A3400BC003C6733AE3BB6BAC43B0F25A83BC03A093800BC003C00BCD836FFBBDD3B003C4A396DBB00BCAC3B003C003CC1BB9CB700BCBD39ADBB2FB3003C003C00BC00BCBAB4003CCEB06BBB45B5FFBB00BCFE3B00BCCCB1BDBBFBBB003CFEBBFDBB003C00BC003CF83BDABB003CA2B3FAA6903588BBFBBBFEBB00BC643B00BCFFBB003C72327F30FE3B00BC003CFABBCDBB00BCFBBB00BC3D3B36B900BC48B83FB700BC00BC003CFCBBE83B913B0CBA00BC7AB500BC1A3714B8363B49B7FFBBE43B3134BEBB003CF8BB62BB003CF438FCBB8A3BFB3BBBBAD73BBD3B00BCC33BE5BBCF3A00BC423B1838EC3BE13B003C03BA003C26B6003C003C003CCFB964B500BC003C9EBBEDBBDE3B31B4003C3CB8B9B9ED3B00BC00BC00BCD9BB003CF9BB00BC00BC003C0EBA9EBB423A003CFEBBD7BBD53B003CFD3BFF3BF13B84BBC93BE2BBE6B600BC00BC62B91AB81B3BB53BE83A003CD9BB00BCA63AFB3B00BC003C003C85B3003CF13BFF3B803B003CEA3B003C3A3BFFBBFABB00BC003CDEBB00BCE7BB003CFDBBB03569BAF2BBC7BB003CA838CDBBFEBBFD3B003CD6B0E237003C933AE43B003C00BCFC3B00BC00BC003C00BCFF3B00BC462E003CFFBB003CAF3A003C003CFEBBFE3BB9BB003C003CEFBBFABBFE3B003C91AEEE3B28BB49BB92BBFC39F9BB00BC003CDCB6003CF036F43B00BC4425FF3B00BCB23000BCF5BB003CFEBB00BC003C003C00BC09B715B7003C00BCC1BB85BB3E2FE539D9BB3E39003CEC3B00BC94B9003CD73BFB3BBCBA00BC003C77B9003CC13B003CFEBA7936B4BBF93BF4BBF53B00BCFFBB00BC723B0EBB003C7538FFBB65AA003C00BC00BCFC3B0434003C00BC10BB463A003C49A6FFBBEFBBE13B93AC003C00BC003C00BC00BCF6BBB3B8003C20B6D139C534003C75B95DBBFEBB003CB830003CFFBBD83B5AA69D3A003C00BC00BC00BC003C4EBBBC35003C753300BC003C14BB00BC003C00BCB2BBDCBB00BC2EB8DF3B003C912C2F389E3B00BC4F3B003CFFBB163BF4BBAEB99A3B003CAD3400BCF73700BCB038003CDBBB00BC00BC003C"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
}

