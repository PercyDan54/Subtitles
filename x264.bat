@echo off
set x264_path=C:\Users\PercyDan\Videos\小丸工具箱rev194\tools
set /p num=
echo Processing...
:: Generate avs script
echo LoadPlugin("%x264_path%\avsfilter\VSFilter.DLL")>%tmp%\1.avs
echo LoadPlugin("%x264_path%\avsfilter\LSMASHSource.DLL")>>%tmp%\1.avs
echo LWLibavVideoSource("D:\剪辑\字幕\万圣街_蓝光_万圣街_%num%.mp4")>>%tmp%\1.avs
echo ConvertToYV12()>>%tmp%\1.avs
echo TextSub("D:\剪辑\字幕\ASS_%num%.ass")>>%tmp%\1.avs
:: Export video with tencent intro cutted off
%x264_path%\x264_32-8bit.exe --seek 576 -o ASS_%num%.mp4 %tmp%\1.avs
:: Add audio track, cut intro
echo Muxing...
%x264_path%\ffmpeg.exe -i 万圣街_蓝光_万圣街_%num%.mp4 -vn -sn -c:a copy -y -map 0:a:0 万圣街_蓝光_万圣街_%num%_audio.aac
"%x264_path%\ffmpeg.exe" -i "万圣街_蓝光_万圣街_%num%_audio.aac" -ss 00:00:24 -y -c copy "万圣街_蓝光_万圣街_%num%_audio_output.aac"
%x264_path%\mp4box.exe -add "ASS_%num%.mp4#trackID=1:par=1:1:name=" -add "万圣街_蓝光_万圣街_%num%_audio_output.aac" -new "ASS_%num%_Mux.mp4" 
:: Delete temp files
del /f /q %tmp%\1.avs >nul
del /f /q *.aac *.lwi "ASS_%num%.mp4"
pause
