package provider

import (
	"github.com/google/uuid"
)

type Provider struct {
	ID        uuid.UUID
	Name      string
	Rate      string
	UpdatedAt string
}
