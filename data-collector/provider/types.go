package provider

import (
	"github.com/google/uuid"
)

// Provider - stores provider data
type Provider struct {
	ID        uuid.UUID
	Name      string
	Rate      string
	UpdatedAt string
}
