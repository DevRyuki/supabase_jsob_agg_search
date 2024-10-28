## リポジトリの目的
Supabaseを使用して、WEBアプリケーションを開発している際に、JSONB型の配列を持つカラムの検索する方法がわからなかったので、調査を行い、実装方法を試した。

## .envについて
ローカル開発することを前提としているため、そのままGithubに.envファイルをアップロードしている。

## 解説
GithubやSupabaseの解説で、JSONB_AGG形式の情報をどのように検索するかが書いていなかったが、頑張って実装した。
ポイントとしては、JSONの文字列に変更することでした。

### AND検索

```typescript
  const supabase = createClient();
  const payload = supabase
  .from("users_likes_view")
  .select("")
  .contains("likes", JSON.stringify([{ like_name: "1" }, {like_name: "2"}]));
```

### OR検索
同じ条件で検索するとして、配列で処理を行なっている。
```typescript
const likeNames = ["1", "2"];
const orConditions = likeNames.map((name) => `likes.cs.${JSON.stringify([{ like_name: name }])}`).join(",");

const supabase = createClient();
const payload = supabase
.from("users_likes_view")
.select("")
.or(orConditions)
```
