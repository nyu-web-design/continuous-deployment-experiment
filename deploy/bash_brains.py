#!/usr/bin/env python

"""
Help out the poor miserable bash script.
"""

import sys
import os

# load the settings file
import json
dir_path = os.path.dirname(os.path.realpath(__file__))
settings = json.load(open(dir_path + '/../settings.json', 'r'))

def get_setting(setting):
  """
  Return the specified setting.
    :returns: the value for the given setting
  """
  return settings[setting]

def get_server():
  """
  Extract the server name from a site URL
  """
  from urllib.parse import urlparse
  site_url = get_setting('site_url')
  result = urlparse(site_url)
  return result.hostname

# return a setting, if requested
if len(sys.argv) > 0:
  arg = sys.argv[1]
  if (arg == 'hostname'):
    print(get_server())
  else:
    print(get_setting(arg))
else:
    raise ValueError('Incorrect usage... must supply the name of a setting.')
