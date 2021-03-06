#include "tesseract/baseapi.h"
#include "leptonica/allheaders.h"

int main()
{
	char *outText;
	tesseract::TessBaseAPI* api = new tesseract::TessBaseAPI();
	if(api->Init(NULL,"eng")) // /usr/local/share
	{
		fprintf(stderr,"could not initialize tesseract.\n");
		exit(1);
	}
	Pix *image = pixRead("/usr/local/share/images/phototest.tif");
	api->SetImage(image);
	outText = api->GetUTF8Text();
	printf("OCR output:\n%s",outText);
	api->End();
	delete[] outText;
	pixDestroy(&image);
	return 0;
}
