#!/bin/bash
#
# 版权所有 (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 这是一个自由软件，遵循 MIT 许可证。
# 更多信息请见 /LICENSE 文件。
#
# https://github.com/P3TERX/Actions-OpenWrt
# 文件名: diy-part1.sh
# 描述: OpenWrt DIY 脚本第一部分 (更新 feeds 之前)

# 修改 RAX3000M eMMC DTS 的 eMMC 频率：52000000 -> 26000000
DTS_FILE="target/linux/mediatek/dts/mt7981b-cmcc-rax3000m-emmc-mtk.dts"
if [ -f "$DTS_FILE" ]; then
  if grep -q "max-frequency = <26000000>;" "$DTS_FILE"; then
    echo "DTS max-frequency 已是 26000000，无需修改"
  elif grep -q "max-frequency = <52000000>;" "$DTS_FILE"; then
    sed -i 's/max-frequency = <52000000>;/max-frequency = <26000000>;/g' "$DTS_FILE"
    if grep -q "max-frequency = <26000000>;" "$DTS_FILE"; then
      echo "已将 $DTS_FILE 中 max-frequency 从 52000000 修改为 26000000"
    else
      echo "错误：修改 $DTS_FILE 失败"
      exit 1
    fi
  else
    echo "警告：$DTS_FILE 中未找到 max-frequency = <52000000>;，跳过修改"
  fi
else
  echo "警告：$DTS_FILE 不存在，跳过 DTS 修改"
fi
