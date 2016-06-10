from cx_Freeze import setup, Executable

setup(name = 'clean_campaign',
      version = '0.1',
      description = 'just clean call-centr campaign',
      executables = [Executable("clean_campaign.py")])