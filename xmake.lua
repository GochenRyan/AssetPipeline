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
        os.cp("$(projectdir)/Vendor/AssetPipeline/build/Debug/*.lib", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/AssetPipeline.lib", "$(projectdir)/lib/AssetPipeline.lib")
        os.trymv("$(projectdir)/lib/AssetPipeline.lib", "$(projectdir)/lib/AssetPipeline.lib")

        os.cp("$(projectdir)/Vendor/freetype/build/Debug/*.pdb", "$(projectdir)/lib/")
        os.trymv("$(projectdir)/lib/AssetPipeline.pdb", "$(projectdir)/lib/AssetPipeline.pdb")
        os.trymv("$(projectdir)/lib/AssetPipeline.pdb", "$(projectdir)/lib/AssetPipeline.pdb")
    end)