
# 必要なテーブル
## usersテーブル
| column |  type  |  null | unique | index |
|:------:|:------:|:-----:|:------:|:-----:|
|  name  | string | false |  false |  true |

## groupsテーブル
| column |  type  |  null | unique | index |
|:------:|:------:|:-----:|:------:|:-----:|
|  name  | string | false |  false | false |

## messagesテーブル
|   column   |    type    |  null | unique | index |
|:----------:|:----------:|:-----:|:------:|:-----:|
|    body    |    text    | false |  false | false |
|    image   |   string   |  true |  false | false |
|   user_id  | references | false |  false | false |
|  group_id  | references | false |  false | false |

messeageはuserとgroupに属しているので、アソシエーションとしてuser_id・group_idを付与した。

## user_groupsテーブル
|  column  |    type    |  null | unique | index |
|:--------:|:----------:|:-----:|:------:|:-----:|
|  user_id | references | false |  false | false |
| group_id | references | false |  false | false |

userとgroupは多対多の関係なので、中間テーブルとしてuser_groupsテーブルを作った。
