Name: hunspell-be-tarask
Summary: Belarusian dictionary for hunspell and classic orthography
Version: 0.60
Release: 1%{?dist}
URL: https://github.com/375gnu/spell-be-tarask/
License: CC-BY-SA
#Source: spell-be-tarask-v0.60-beta1.tar.gz
BuildArch: noarch
BuildRequires: make
Requires: hunspell
Conflicts: hunspell-be

%description
This package contains Belarusian dictionary for the hunspell
spell-checker currently supported by LibreOffice and Mozilla.

This dictionary is for the recent taraskievica orthography.

%prep
%setup -n spell-be-tarask-0.60

%build
make dict

%install
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/myspell
cp -p be_BY@tarask.aff $RPM_BUILD_ROOT/%{_datadir}/myspell/be_BY@tarask.aff
cp -p be_BY@tarask.dic $RPM_BUILD_ROOT/%{_datadir}/myspell/be_BY@tarask.dic
ln -s be_BY@tarask.aff $RPM_BUILD_ROOT/%{_datadir}/myspell/be_BY.aff
ln -s be_BY@tarask.dic $RPM_BUILD_ROOT/%{_datadir}/myspell/be_BY.dic

%files
%license LICENSE
%doc README README_spell_be_BY.txt
%{_datadir}/myspell/*

%changelog
* Sun Apr 28 2024 Hleb Valoshka <375gnu@gmail.com> - 0.60-1
- Update to version 0.60.

* Sun Apr 21 2024 Hleb Valoshka <375gnu@gmail.com> - 0.60~beta2-1
- Update to version 0.60~beta2.

* Tue Apr 16 2024 Hleb Valoshka <375gnu@gmail.com> - 0.60~beta1-1
- Initial RPM packaging.
