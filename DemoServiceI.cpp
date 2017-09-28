#include <Demo.h>
#include <Ice/Ice.h>
#include <IceBox/IceBox.h>

class DemoInterfaceI : public DemoModule::DemoInterface
{
public:
	auto method(const Ice::Current&) -> DemoModule::SearchResponsePtr override
	{
		return new DemoModule::SubSearchResponse();
	}
};

class DemoServiceI : public IceBox::Service
{
	Ice::ObjectAdapterPtr _adapter;

public:
	void start(const std::string& name, const Ice::CommunicatorPtr& communicator, const Ice::StringSeq&)
	{
		_adapter = communicator->createObjectAdapter(name);
		_adapter->add(new DemoInterfaceI(), communicator->stringToIdentity("DemoObject"));
		_adapter->activate();
	}

	virtual void stop()
	{
		_adapter->destroy();
	}
};

extern "C" {
ICE_DECLSPEC_EXPORT
IceBox::Service* create(Ice::CommunicatorPtr communicator)
{
	return new DemoServiceI;
}
}
