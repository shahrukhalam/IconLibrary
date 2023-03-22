import PackagePlugin

@main
struct AssetConstants: BuildToolPlugin {
    func createBuildCommands(context: PackagePlugin.PluginContext, target: PackagePlugin.Target) async
    throws -> [PackagePlugin.Command] {
        guard let target = target as? SourceModuleTarget else {
            return []
        }
        
        let tool = try context.tool(named: "AssetConstantsExec")
        
        return target.sourceFiles(withSuffix: "xcassets").map { assetCatalog in
            let base = assetCatalog.path.stem
            let input = assetCatalog.path
            
            let output = context.pluginWorkDirectory
                .appending(["Generated", "\(base).swift"])
            let arguments = [input.string, output.string]
            
            return .buildCommand(
                displayName: "Generating constants for \(base)",
                executable: tool.path,
                arguments: arguments,
                inputFiles: [input],
                outputFiles: [output]
            )
        }
    }
}
