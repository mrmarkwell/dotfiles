local fmt = require('luasnip.extras.fmt').fmt
return {
  -- important! fmt does not return a snippet, it returns a table of nodes.
  s('snip_tracing', t('#include "android/aicore/backend/api/common/tracing.h"')),
  s('RUNTIME', t('AICORE_RUNTIME_FUNCTION(')),
  s('RETLE', t('RET_CHECK_LE(embedding_metadata.size(), ')),
  s('RRR', t('AICORE_RUNTIME_FUNCTION(')),
  s(
    'BEGIN_PUBLIC',
    fmt(
      [[
      BEGIN_PUBLIC

      {}

      END_PUBLIC

  ]],
      {
        -- i(1) is at nodes[1]
        i(1, 'Internal change'),
      }
    )
  ),
  s('BUG', t('BUG=498784175')),
  s('NO_BUG', t('NO_BUG=no bug')),
  s(
    'TODO',
    fmt(
      [[
      // TODO: b/{} - 
      ]],
      {
        -- i(1) is at nodes[1]
        i(1, '425783496'),
      }
    )
  ),
  s('BYPASS', t('BYPASS_AICORE_GUITAR=no affected tests.')),
  s('VLOG', t('VLOG(1) << "MARKWELLDEBUG: " << ')),
  s(
    'MARKWELL',
    fmt(
      [[
      int dbg_counter = 0;
      VLOG(1) << "MARKWELLDEBUG: {}" << dbg_counter++;
      ]],
      {
        -- i(1) is at nodes[1]
        i(1, 'HERE: '),
      }
    )
  ),
  s(
    'example1',
    fmt('just an {iNode1}', {
      iNode1 = i(1, 'example'),
    })
  ),
  s(
    'example2',
    fmt(
      [[
  if {} then
    {}
  end
  ]],
      {
        -- i(1) is at nodes[1], i(2) at nodes[2].
        i(1, 'not now'),
        i(2, 'when'),
      }
    )
  ),
  s(
    'example3',
    fmt(
      [[
  if <> then
    <>
  end
  ]],
      {
        -- i(1) is at nodes[1], i(2) at nodes[2].
        i(1, 'not now'),
        i(2, 'when'),
      },
      {
        delimiters = '<>',
      }
    )
  ),
  s(
    'example4',
    fmt(
      [[
  repeat {a} with the same key {a}
  ]],
      {
        a = i(1, 'this will be repeat'),
      },
      {
        repeat_duplicates = true,
      }
    )
  ),
  s(
    'example5',
    fmt(
      [[
    line1: no indent

      line3: 2 space -> 1 indent ('\t')
        line4: 4 space -> 2 indent ('\t\t')
  ]],
      {},
      {
        indent_string = '  ',
      }
    )
  ),
  -- NOTE: [[\t]] means '\\t'
  s(
    'example6',
    fmt(
      [[
    line1: no indent

    \tline3: '\\t' -> 1 indent ('\t')
    \t\tline4: '\\t\\t' -> 2 indent ('\t\t')
  ]],
      {},
      {
        indent_string = [[\t]],
      }
    )
  ),
}
