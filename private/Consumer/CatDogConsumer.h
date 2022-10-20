#pragma once

#include "Consumer/BaseConsumer.h"

namespace cdtools
{

class CatDogConsumer final : public BaseConsumer
{
public:
	using BaseConsumer::BaseConsumer;
	virtual void Execute(const SceneDatabase* pSceneDatabase) override;
};

}