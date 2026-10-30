# Lab 11.4 - App Dependencies and Supersedence

## Dependencies

A dependency is an application that must be installed/detected before the primary app can proceed. Example: a business application may require a runtime.

1. Create and validate the prerequisite Win32 app.
2. Create the primary app.
3. Open Dependencies and add the prerequisite.
4. Configure the appropriate install behavior.
5. Test on a clean device and confirm prerequisite installation/detection before the primary app completes.

## Supersedence

Supersedence links a newer package to an older app version.

1. Package and validate version 1.
2. Package version 2 and create a new Win32 app entry.
3. Configure Supersedence on version 2 to reference version 1.
4. Decide whether the superseded app should be uninstalled based on vendor upgrade behavior.
5. Assign version 2 to a pilot group and validate upgrade, detection, launch, and data retention.

## Troubleshooting

Check dependency detection, assignment scope, install context, version detection, installer return codes, and vendor in-place upgrade support.

## Security and rollback

Use signed trusted packages. Keep a known-good previous package and test data backup. Rollback may require a separate assignment to redeploy the previous version; supersedence is not itself a rollback mechanism.

## Exercise

Create a two-version test deployment and document whether the older version is removed or upgraded in place.
