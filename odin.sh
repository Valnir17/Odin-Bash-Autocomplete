# Define the commands
_odin_commands="build check doc report root run strip-semicolon test version"

# Define the completion function
_odin_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # Complete commands
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${_odin_commands}" -- ${cur}) )
        return 0
    fi

    # Complete targets (files in the current directory or ".")
    if [[ ${COMP_CWORD} -eq 2 && "$prev" != "report" && "$prev" != "version" && "$prev" != "root" ]]; then
        local files=$(find . -maxdepth 1 -type f -printf "%f\n")
        COMPREPLY=( $(compgen -W "${files} ." -- ${cur}) )
        return 0
    fi

    # Skip flag completion for report, version, and root commands
    if [[ "$prev" == "report" || "$prev" == "version" || "$prev" == "root" ]]; then
        return 0
    fi

    # Special case for -o: flag [Currently not working!]
    if [[ "${COMP_WORDS[1]}" == "odin" && "${cur}" == "-o:" ]]; then
        opts="size none speed minimal"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    # Do the same for sanitize and other flags with limited sub-options 


    # Complete flags and their subelements based on the command
    case "${COMP_WORDS[1]}" in
        build)
            opts="
                -file
                -out:
                -o:
                -show-timings
                -show-more-timings
                -show-system-calls
                -export-timings
                -export-timings-file:
                -export-dependencies:
                -export-dependencies-file:
                -thread-count
                -keep-temp-files
                -collection
                -define
                -show-defineables
                -export-defineables:
                -build-mode:
                -target:
                -debug
                -disable-assert
                -no-bounds-check
                -no-type-assert
                -no-crt
                -no-rpath
                -no-thread-local
                -lld
                -use-separate-modules
                -no-threaded-checker
                -vet
                -vet-unused
                -vet-unused-variables
                -vet-unused-imports
                -vet-shadowing
                vet-using-stmt
                -vet-using-param
                -vet-style
                -vet-semicolon
                -vet-cast
                -vet-tabs
                -vet-packages:
                -vet-unused-procedures
                -custom-attribute:
                -ignore-unknown-attributes
                -no-entry-point
                -extra-linker-flags:
                -extra-assembler-flags:
                -microarch:
                -target-features:
                -strict-target-features
                -reloc-mode:
                -disable-red-zone
                -dynamic-map-calls
                -print-linker-flags
                -disallow-do
                -default-to-nil-allocator
                -strict-style
                -ignore-warnings
                -warnings-as-errors
                -terse-errors
                -error-pos-style
                -max-error-count:
                -min-link-libs
                -foreign-error-procedures
                -obfuscate-source-code-locations
                -sanitize:
            "
            compopt -o nospace -o noquote

            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        check)
            opts="
                -file
                -show-timings
                -show-more-timings
                -show-system-calls
                -export-timings:
                -export-timings-file:
                -export-dependencies:
                -export-dependencies-file:
                -thread-count:
                -show-unused
                -show-unused-with-location
                -collection:
                -define:
                -show-defineables
                -export-defineables
                -target:
                -no-threaded-checker
                -vet
                -vet-unused
                -vet-unused-variables
                -vet-shadowing
                -vet-using-stmt
                -vet-using-param
                -vet-style
                -vet-semicolon
                -vet-cast
                -vet-tabs
                -vet-packages:
                -vet-unused-procedures
                -custom-attribute:
                -ignore-unknown-attributes
                -no-entry-point
                -disallow-do
                -default-to-nil-allocator
                -strict-style
                -ignore-warnings
                -warnings-as-errors
                -terse-errors
                -json-errors
                -error-pos-style:
                -max-error-count:
                -min-link-libs
                -foreign-error-procedures
            "
            compopt -o nospace -o noquote
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        doc)
            opts="
                -help
                -short
                -all-packages
                -doc-format
                -out:
            "
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        run)
            opts="                
            	-file
                -show-timings
                -show-more-timings
                -show-system-calls
                -export-timings:
                -export-timings-file:
                -export-dependencies:
                -export-dependencies-file:
                -thread-count:
                -show-unused
                -show-unused-with-location
                -collection:
                -define:
                -show-defineables
                -export-defineables
                -target:
                -debug
                -disable-assert
                -no-threaded-checker
                -vet
                -vet-unused
                -vet-unused-variables
                -vet-shadowing
                -vet-using-stmt
                -vet-using-param
                -vet-style
                -vet-semicolon
                -vet-cast
                -vet-tabs
                -vet-packages:
                -vet-unused-procedures
                -custom-attribute:
                -ignore-unknown-attributes
                -no-entry-point
                -disallow-do
                -default-to-nil-allocator
                -strict-style
                -ignore-warnings
                -warnings-as-errors
                -terse-errors
                -json-errors
                -error-pos-style:
                -max-error-count:
                -min-link-libs
                -foreign-error-procedures
            "
            compopt -o nospace -o noquote
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        strip-semicolon)
            opts="
            -file
            -show-timings
            -show-more-timings
            -show-system-calls
            -export-timings:
            -export-timings-file:
            -export-dependencies:
            -export-dependencies-file:
            -thread-count:
            -show-unused
            -show-unused-with-location
            -keep-temp-files
            -collection:
            -define:
            -show-defineables
            -export-defineables:
            -target:
            -no-threaded-checker
            -vet
            -vet-unused
            -vet-unused-variables
            -vet-unused-imports
            -vet-shadowing
            -vet-using-stmt
            -vet-using-param
            -vet-style
            -vet-semicolon
            -vet-cast
            -vet-tabs
            -vet-packages:
            -vet-unused-procedures
            -custom-attribute:
            -ignore-unknown-attributes
            -no-entry-point
            -disallow-do
            -default-to-nil-allocator
            -strict-style
            -ignore-warnings
            -warnings-as-errors
            -terse-errors
            -json-errors
            -error-pos-style
            -max-error-count
            -min-link-libs
            -foreign-error-procedures
            "
            compopt -o nospace -o noquote
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        test)
            opts="
            -file
            -out:
            -o:
            -show-timings
            -show-more-timings
            -show-system-calls
            -export-timings:
            -export-timings-file:
            -export-dependencies:
            -export-dependencies-file:
            -thread-count:
            -keep-temp-files:
            -collection:
            -define:
            -show-defineables
            -export-defineables:
            -target:
            -debug
            -disable-assert
            -no-bounds-check
            -no-crt
            -no-rpath
            -no-thread-local
            -lld
            -use-separate-modules
            -no-threaded-checker
            -vet
            -vet-unused
            -vet-unused-variables
            -vet-unused-imports
            -vet-shadowing
            -vet-using-stmt
            -vet-using-param
            -vet-style
            -vet-semicolon
            -vet-cast
            -vet-tabs
            -vet-packages:
            -vet-unused-procedures
            -custom-attribute:
            -ignore-unknown-attributes
            -all-packages
            -minimum-os-version:
            -extra-linker-flags:
            -extra-assembler-flags:
            -microarch:
            -target-features:
            -strict-target-features
            -reloc-mode:
            -disable-red-zone
            -disallow-do
            -default-to-nil-allocator
            -strict-style
            -ignore-warnings
            -warnings-as-errors
            -terse-errors
            -json-errors
            -error-pos-style:
            -max-error-count:
            -min-link-libs
            -foreign-error-procedures
            -obfuscate-source-code-locations
            -sanitize:

             "
            compopt -o nospace -o noquote
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
        *)
            opts=""
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
    esac

    return 0
}

# Register the completion function
complete -F _odin_completions odin