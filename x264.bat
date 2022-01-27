@echo off
set x264_path=C:\Users\PercyDan\Videos\xw toolbox\tools
set /p num=
echo Processing...

:: Generate avs script
echo LoadPlugin("%x264_path%\avsfilter\VSFilter.DLL")>%tmp%\1.avs
echo LoadPlugin("%x264_path%\avsfilter\LSMASHSource.DLL")>>%tmp%\1.avs
echo LWLibavVideoSource("D:\¼ô¼­\×ÖÄ»\ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%.mp4")>>%tmp%\1.avs
echo ConvertToYV12()>>%tmp%\1.avs
echo TextSub("D:\¼ô¼­\×ÖÄ»\ASS_%num%.ass")>>%tmp%\1.avs

:: Export video
REM "%x264_path%\x264_32-8bit.exe" --seek 576 -o ASS_%num%.mp4 %tmp%\1.avs
"%x264_path%\x264_32-8bit.exe" -o ASS_%num%.mp4 %tmp%\1.avs

:: Add audio track, cut intro
echo Muxing...
"%x264_path%\ffmpeg.exe" -i ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%.mp4 -vn -sn -c:a copy -y -map 0:a:0 ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%_audio.aac
::"%x264_path%\ffmpeg.exe" -i "ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%_audio.aac" -ss 00:00:24 -y -c copy "ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%_audio_output.aac"
"%x264_path%\mp4box.exe" -add "ASS_%num%.mp4#trackID=1:par=1:1:name=" -add "ÍòÊ¥½Ö_À¶¹â_ÍòÊ¥½Ö_%num%_audio.aac" -new "ASS_%num%_Mux.mp4" 

:: Delete temp files
del /f /q %tmp%\1.avs >nul
del /f /q *.aac *.lwi "ASS_%num%.mp4"
pause