FROM microsoft/windowsservercore

# Copy default texlive.profile
# This file is created by executing install-tl-windows.bat --gui=text
COPY texlive.profile .

# Download install-tl.zip
RUN powershell -Command Invoke-WebRequest "http://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl.zip" -OutFile "install-tl.zip"

# Extract zip file
RUN powershell -Command Expand-Archive -Path .\install-tl.zip -Destination .

# Run install-tl-windows.bat
RUN powershell -Command "ls 'install-tl-*' | cd; & ./install-tl-windows.bat --profile=../texlive.profile"

# Delete tmp files
RUN powershell -Command Remove-Item -recurse ('install-tl-*', 'install-tl.zip', 'texlive.profile')
