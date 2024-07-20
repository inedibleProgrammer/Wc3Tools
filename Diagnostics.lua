function map.Diagnostics_Create(commands, logging)
  local diagnostics = {}
  diagnostics.commands = commands
  diagnostics.logging = logging

  function diagnostics.Display()
    local diagnosticMessage = {}
    diagnosticMessage.message = garbagecollec("count")
    diagnosticMessage.type = logging.types.INFO
    logging.Write(diagnosticMessage)
  end

  return diagnostics
end
