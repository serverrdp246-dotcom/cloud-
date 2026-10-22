#!/bin/bash

echo "=== 1. إنشاء حساب الأدمن الوهمي (fakeadmin) ==="
# إنشاء المستخدم إذا لم يكن موجوداً
if ! id "fakeadmin" &>/dev/null; then
    sudo useradd -m -s /bin/bash fakeadmin
    echo "fakeadmin:password123" | sudo chpasswd
    sudo usermod -aG sudo fakeadmin
    echo "fakeadmin ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/fakeadmin
    sudo chmod 0440 /etc/sudoers.d/fakeadmin
    echo "تم إنشاء المستخدم fakeadmin بنجاح!"
fi

echo "=== 2. تحديث النظام وتثبيت المكونات الأساسية ==="
sudo apt-get update && sudo apt-get install -y \
    wget \
    curl \
    unzip \
    git \
    openjdk-17-jdk \
    libglu1-mesa \
    libpulse0 \
    libasound2 \
    libxi6 \
    libxrender1 \
    libxtst6 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2

echo "=== 3. إعداد متغيرات بيئة Java ==="
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

echo "=== 4. تحميل وتثبيت Android Studio ==="
cd /tmp
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2024.2.1.12/android-studio-2024.2.1.12-linux.tar.gz -O android-studio.tar.gz

echo "فك الضغط عن Android Studio..."
sudo tar -xzf android-studio.tar.gz -C /opt/
sudo chown -R fakeadmin:fakeadmin /opt/android-studio

# إنشاء اختصار تشغيل
sudo ln -sf /opt/android-studio/bin/studio.sh /usr/local/bin/android-studio

echo "=== تم التثبيت بنجاح! ==="
