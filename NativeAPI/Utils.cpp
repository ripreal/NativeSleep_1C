
#include "Utils.h"
#include <iostream>
#include <string>

void Utils::convetToWChar(wchar_t* buffer, const char* text)
{
	size_t size = strlen(text) + 1;

	size_t outSize;
	mbstowcs_s(&outSize, buffer, size, text, size - 1);
};

std::string Utils::convertToString(wchar_t* text)
{
	std::wstring ws(text);
	std::string result(ws.begin(), ws.end());
	return result;
}
