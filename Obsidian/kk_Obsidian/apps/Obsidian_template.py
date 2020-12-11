#!/usr/bin/env python3

import datetime
import os
dairyfilepath = '.md'

#日付の取得
today = datetime.date.today()
yesterday = today - datetime.timedelta(days=1)
tommorow = today + datetime.timedelta(days=1)

#テンプレートの中身
notebody = f'''
# {today}
<<[[{yesterday} |yesterday]] [[{tommorow} |tommorow]]>>

--do--

--memo--
'''

#ファイルに書き込み
with open(str(today) + dairyfilepath, mode='w') as f:
     f.write(notebody)
