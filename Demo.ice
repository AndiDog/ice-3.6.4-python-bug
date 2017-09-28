#ifndef DEMO_ICE
#define DEMO_ICE

module DemoModule
{
	class SearchResponse
	{
	};

	class SubSearchResponse extends SearchResponse {};

	interface DemoInterface
	{
		SearchResponse method();
	};
};

#endif
