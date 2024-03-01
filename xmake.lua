target("AssetPipeline")
    add_includedirs(
        "$(projectdir)/Vendor/AssetPipeline/public/"
    )

    on_build("windows", function(target)
        os.cd("$(projectdir)/Vendor/AssetPipeline")

        local msbuild_path, errdata = os.iorun("find_msbuild.bat")
        local solution_file = "AssetPipeline.sln"
        local platform = "x64"

        if (is_mode("debug"))
        then
            os.run("make_win64_vs2022.bat")
            local configuration = "Debug"
            os.run('"%s" -m %s /p:Configuration=%s /p:Platform=%s', msbuild_path, solution_file, configuration, platform)
        else
            os.run("make_win64_vs2022.bat")
            local configuration = "Release"
            os.run('"%s" -m %s /p:Configuration=%s /p:Platform=%s', msbuild_path, solution_file, configuration, platform)
        end
        os.cd("$(projectdir)")
    end)

    after_build("windows", function(target)
        if (is_mode("debug"))
        then
            os.cp("$(projectdir)/Vendor/AssetPipeline/build/bin/Debug/AssetPipelineCore.lib", "$(projectdir)/lib/")
            os.cp("$(projectdir)/Vendor/AssetPipeline/build/bin/Debug/AssetPipelineCore.pdb", "$(projectdir)/lib/")
        else
            os.cp("$(projectdir)/Vendor/AssetPipeline/build/bin/Release/AssetPipelineCore.lib", "$(projectdir)/lib/")
            os.cp("$(projectdir)/Vendor/AssetPipeline/build/bin/Release/AssetPipelineCore.pdb", "$(projectdir)/lib/")
        end
    end)

    set_group("Vendor")