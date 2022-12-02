augroup filetypedetect
    " 読み込み時、新規ファイル作成時に、Makefileだったら、Makefile用の設定ファイルを読み込む
    au BufRead, BufNewFile Makefile setfiletype Makefile 
augroup END
