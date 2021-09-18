object UniServerModule: TUniServerModule
  OldCreateOrder = False
  TempFolder = 'temp\'
  Title = 'Google Charts - uniGUI'
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomCSS.Strings = (
    '.CodeMirror-wrapping {'
    '    position: relative !important;'
    '}')
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvTLSv1_1
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  Options = [soAutoPlatformSwitch, soWipeShadowSessions, soDontCompressDownloads]
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  Height = 150
  Width = 215
end
