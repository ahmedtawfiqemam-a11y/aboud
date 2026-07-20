#!/bin/bash
set -e

echo "▶ جاري تحميل المشروع..."

# جلب الكود الخاص وقت التشغيل بس - مش بيتخزن في الصورة
git clone https://$GITHUB_CLONE_TOKEN@github.com/ahmedtawfiqemam-a11y/SOURCEAboud.git /app/src 2>/dev/null
echo "✅ تم تحميل المشروع"

cd /app/src

echo "▶ تثبيت حزم Python..."
python3.11 -m pip install --no-cache-dir --ignore-installed -r requirements.txt -q
echo "✅ تم تثبيت Python"

echo "▶ تثبيت Baileys..."
cd baileys_service && npm install --production --silent && cd ..
echo "✅ تم تثبيت Baileys"

echo "▶ بناء Go Sniper..."
bash build_sniper.sh 2>/dev/null || echo "⚠️ تخطي Go Sniper"

echo "▶ تشغيل البوت..."
exec python -u main.py
