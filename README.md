# 共通の Fastfile

## 使い方

自分の Fastfile に以下の行を追加する(default_platform の下辺りとか)

```ruby
import_from_git(url: "git@github.com:covelline/fastfile.git",
                path: 'fastlane/Fastfile')
```

`fastlane lanes` ってやってここで定義されている lane が出れば問題なし。 あとは普通に呼び出して使える。

