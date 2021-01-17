
rm -r setuptools-$surum/{pkg_resources,setuptools}/{extern,_vendor}

  for _module in setuptools pkg_resources '' ; do
      find setuptools-$surum -name \*.py -exec sed -i \
          -e 's/from '$_module.extern' import/import/' \
          -e 's/from '$_module.extern'./from /' \
          -e 's/import '$_module.extern'./import /' \
          -e "s/__import__('$_module.extern./__import__('/" \
          {} +
  done

  sed -i '/ignore:lib2to3 package is deprecated:DeprecationWarning/a \    ignore:Creating a LegacyVersion has been deprecated and will be removed in the next major release:DeprecationWarning' \
      setuptools-$surum/pytest.ini

  # Remove post-release tag since we are using stable tags
  sed -e '/tag_build = .post/d' \
      -e '/tag_date = 1/d' \
      -i setuptools-$surum/setup.cfg

  # 'Clean' installation is expected to fail since we removed bundled packages
  sed -i '/^def test_clean_env_install/i @pytest.mark.xfail' setuptools-$surum/setuptools/tests/test_virtualenv.py
  sed -e '/^def test_pip_upgrade_from_source/i @pytest.mark.xfail' \
      -e '/^def test_test_command_install_requirements/i @pytest.mark.xfail' \
      -e '/^def test_no_missing_dependencies/i @pytest.mark.xfail' \
      -i setuptools-$surum/setuptools/tests/test_virtualenv.py
   cd "$SRC"/setuptools-$surum
#  sed -i -e "s|^#\!.*/usr/bin/env python|#!/usr/bin/env python3|" setuptools/command/easy_install.py
  /usr/bin/python3 bootstrap.py
  /usr/bin/python3 setup.py build

