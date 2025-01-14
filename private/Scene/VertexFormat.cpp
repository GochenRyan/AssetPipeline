#include "Scene/VertexFormat.h"
#include "VertexFormatImpl.h"

namespace cd
{

VertexFormat::VertexFormat()
{
	m_pVertexFormatImpl = new VertexFormatImpl();
}

VertexFormat::VertexFormat(const VertexFormat& rhs)
{
	*this = rhs;
}

VertexFormat& VertexFormat::operator=(const VertexFormat& rhs)
{
	m_pVertexFormatImpl = new VertexFormatImpl();
	*m_pVertexFormatImpl = *rhs.m_pVertexFormatImpl;
	return *this;
}

VertexFormat::VertexFormat(VertexFormat&& rhs)
{
	*this = cd::MoveTemp(rhs);
}

VertexFormat& VertexFormat::operator=(VertexFormat&& rhs)
{
	std::swap(m_pVertexFormatImpl, rhs.m_pVertexFormatImpl);
	return *this;
}

VertexFormat::~VertexFormat()
{
	if (m_pVertexFormatImpl)
	{
		delete m_pVertexFormatImpl;
		m_pVertexFormatImpl = nullptr;
	}
}

void VertexFormat::AddAttributeLayout(VertexAttributeType attributeType, AttributeValueType valueType, uint8_t count)
{
	m_pVertexFormatImpl->AddAttributeLayout(attributeType, valueType, count);
}

const std::vector<VertexAttributeLayout>& VertexFormat::GetVertexLayout() const
{
	return m_pVertexFormatImpl->GetVertexLayout();
}

bool VertexFormat::Contains(VertexAttributeType attributeType) const
{
	return m_pVertexFormatImpl->Contains(attributeType);
}

bool VertexFormat::IsCompatiableTo(const VertexFormat& other) const
{
	return m_pVertexFormatImpl->IsCompatiableTo(*other.m_pVertexFormatImpl);
}

uint32_t VertexFormat::GetStride() const
{
	return m_pVertexFormatImpl->GetStride();
}

VertexFormat& VertexFormat::operator<<(InputArchive& inputArchive)
{
	*m_pVertexFormatImpl << inputArchive;
	return *this;
}

VertexFormat& VertexFormat::operator<<(InputArchiveSwapBytes& inputArchive)
{
	*m_pVertexFormatImpl << inputArchive;
	return *this;
}

const VertexFormat& VertexFormat::operator>>(OutputArchive& outputArchive) const
{
	*m_pVertexFormatImpl >> outputArchive;
	return *this;
}

const VertexFormat& VertexFormat::operator>>(OutputArchiveSwapBytes& outputArchive) const
{
	*m_pVertexFormatImpl >> outputArchive;
	return *this;
}

}