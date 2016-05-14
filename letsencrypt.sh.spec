Summary:	letsencrypt/acme client implemented as a shell-script
Name:		letsencrypt.sh
Version:	0.1.0
Release:	0.1
License:	MIT
Group:		Applications/Networking
Source0:	https://github.com/lukas2511/letsencrypt.sh/archive/v%{version}/%{name}-%{version}.tar.gz
# Source0-md5:	eb1208bcf5c33a6f030da9419718bf6b
URL:		https://github.com/lukas2511/letsencrypt.sh
BuildRequires:	rpmbuild(macros) >= 1.713
Requires:	curl
Requires:	grep
Requires:	mktemp
Requires:	openssl
Requires:	sed
BuildArch:	noarch
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
This is a client for signing certificates with an ACME-server
(currently only provided by letsencrypt) implemented as a relatively
simple bash-script.

Current features:
- Signing of a list of domains
- Signing of a CSR
- Renewal if a certificate is about to expire or SAN (subdomains)
  changed
- Certificate revocation

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc README.md CHANGELOG LICENSE
