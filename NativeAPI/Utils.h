
#pragma once
#include <types.h>
#include <string>

class Utils
{
public:
	static void convetToWChar(wchar_t* buffer, const char* text);
	static std::string convertToString(wchar_t* text);
};