# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-01-04

### Added
- Initial release of FastAPI backend with OAuth2 JWT authentication
- User registration endpoint (`POST /api/v1/auth/register`)
- User login endpoints (OAuth2 form and JSON)
- Protected user endpoint (`GET /api/v1/users/me`)
- PostgreSQL database integration (192.168.0.112:5432)
- Automatic database table creation
- Password hashing with bcrypt
- JWT token generation and validation
- CORS middleware for React.js frontend integration
- Interactive API documentation (Swagger UI and ReDoc)
- Environment-based configuration
- Production-ready project structure

### Fixed
- Missing `.env` file configuration
- Bcrypt compatibility issue (pinned to version 3.2.2)
- Virtual environment path in start.sh script

### Changed
- Consolidated all documentation into single comprehensive guide
- Updated README.md to be concise with pointer to full docs
- Organized project documentation structure

### Security
- Secure password hashing with bcrypt
- JWT tokens with 30-minute expiration
- OAuth2 bearer token authentication
- SQL injection prevention via SQLAlchemy ORM
- Input validation with Pydantic models

---

## Future Releases

For detailed information about the current release and future roadmap, see [DOCUMENTATION.md](DOCUMENTATION.md).

### Planned for v1.1.0
- Alembic database migrations
- Structured logging
- Custom exception handlers
- Comprehensive test suite
- Docker containerization

### Planned for v1.2.0
- Rate limiting
- Pagination utilities
- Enhanced health checks
- Request ID tracking middleware

### Planned for v2.0.0
- Background task processing
- Monitoring with Prometheus
- CI/CD pipeline
- WebSocket support
- Caching layer with Redis

---

**For complete changelog details, see [DOCUMENTATION.md](DOCUMENTATION.md#changelog)**
