#!/bin/sh

lang=xeng
fontname='FreeSerifBold'
font='FreeSerif Bold'
font_properties='font_properties'
inputtext=train_text
resultdir=result

#mftraining inputs
#new in 3.01
echo ${fontname} 1 0 0 1 0 > ${resultdir}/${font_properties}

shortname=${lang}.${fontname}.exp0

mkdir ${resultdir}

text2image --text=${inputtext} --outputbase=${resultdir}/${shortname} --font=${font} --fonts_dir=/usr/share/fonts

tesseract ${resultdir}/${shortname}.tif ${resultdir}/${shortname} batch.nochop makebox

sudo cp ../tessdata/eng.traineddata /usr/local/share/tessdata/
tesseract ${resultdir}/${shortname}.tif ${resultdir}/${shortname} nobatch box.train

unicharset_extractor ${resultdir}/${shortname}.box
mv unicharset ${resultdir}

mftraining -F ${resultdir}/${font_properties}  -U ${resultdir}/unicharset -O ${resultdir}/${lang}.unicharset ${resultdir}/${shortname}.tr
cntraining ${resultdir}/${shortname}.tr


mv inttemp ${resultdir}/${lang}.inttemp
mv pffmtable ${resultdir}/${lang}.pffmtable
mv normproto ${resultdir}/${lang}.normproto
mv shapetable ${resultdir}/${lang}.shapetable

combine_tessdata ${resultdir}/${lang}.


sudo cp ${resultdir}/${lang}.traineddata /usr/local/share/tessdata/

echo "tesseract image.tif output -l ${lang}"


