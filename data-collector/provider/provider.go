package provider

type Provider interface {
	rate() string
	name() string
	updatedAt() string
}

type Banxico struct {
	Name      string
	Rate      string
	UpdatedAt string
}

type DiarioOficialFederacion struct {
	Name      string
	Rate      string
	UpdatedAt string
}

type Fixer struct {
	Name      string
	Rate      string
	UpdatedAt string
}
