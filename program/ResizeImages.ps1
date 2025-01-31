function Resize-ImagesToMaxWidth1920 {
    param (
        [string]$DirectoryPath
    )

    # ImageMagickのコンバートツールへのパス
    $convertPath = "magick.exe"

    # 指定したフォルダのパスを取得
    $currentDir = Get-Item -Path $DirectoryPath

    # 一つ上のフォルダを取得
    $parentDir = Split-Path $currentDir.FullName -Parent

    # JPGファイルをすべて取得
    $jpgFiles = Get-ChildItem -Path $currentDir.FullName -Filter *.jpg

    # 各ファイルをリサイズして保存
    foreach ($file in $jpgFiles) {
        Write-Host("hoge")
        # 元のファイルパス
        $inputFile = $file.FullName

        # 画像の幅を取得
        $imageInfo = & $convertPath identify -format "%w" $inputFile
        $width = [int]$imageInfo

        if ($width -gt 1920) {
            # 新しいファイルパス（親フォルダに保存）
            $outputFile = Join-Path -Path $parentDir -ChildPath $file.Name

            # 横幅を1920pxにリサイズ
            & $convertPath $inputFile -resize 1920 $outputFile
            Write-Output "$inputFile の幅を1920pxにリサイズしました。"
        } else {
            Write-Output "$inputFile の幅は1920px未満のため、そのままです。"
        }
    }

    # Write-Output "リサイズ完了。ファイルは一つ上のフォルダに保存されました。"
}
